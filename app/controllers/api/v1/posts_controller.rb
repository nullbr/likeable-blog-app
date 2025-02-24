module Api
  module V1
    class PostsController < ApiController
      before_action :find_user, only: :rate
      before_action :find_post, only: :rate

      def create
        user = find_or_initialize_user

        return render_errors(user.errors.full_messages) unless user.save

        post = create_post_for_user(user)

        return render_errors(post.errors.full_messages) unless post.save

        render json: post.as_json(include: :user), status: :created
      end

      def rate
        rating = @post.ratings.find_or_initialize_by(user: @user)
        rating.value = params[:value]

        return render_errors(rating.errors.full_messages) unless rating.save

        render json: { average_rating: post.average_rating }
      end

      def top_posts
        top_n = params[:n].to_i
        posts = Post
          .select("posts.id, posts.title, posts.body, AVG(ratings.value) AS average_rating")
          .joins(:ratings)
          .order("AVG(ratings.value) DESC")
          .group("posts.id")
          .limit(top_n.positive? ? top_n : 100)

        render json: posts
      end

      def ip_authors
        result = Post
          .select("posts.ip, ARRAY_AGG(DISTINCT users.login) AS authors")
          .joins(:user)
          .group(:ip)
          .having("COUNT(DISTINCT user_id) > 1")

        render json: result.as_json(only: %i[ip authors])
      end

      private

      def find_or_initialize_user
        User.find_or_initialize_by(login: post_params[:login])
      end

      def create_post_for_user(user)
        user.posts.new(post_params.except(:login))
      end

      def find_user
        @user = User.find_by(id: params[:user_id])

        render_record_not_found(@user)
      end

      def find_post
        @post = Post.find_by(id: params[:post_id])

        render_record_not_found(@post)
      end

      def post_params
        params.expect(post: %i[title body login ip])
      end
    end
  end
end
