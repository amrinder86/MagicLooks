class MirrorsController < ApplicationController

    def index
      #@face_ids = User.select { |u| u.person_id }
      @person_ids = {}
      # @face_ids["person_id"] = {'Users_info'}

      User.all.each do |u|
        @person_ids[u.person_id] = u.id
      end

      respond_to do |f|
        f.html { render json: @person_ids }
      end
    end

    def show
      @mirror = Mirror.find(params[:id])
      @user = User.find(params[:id])

      respond_to do |f|
        f.html { render  json: @mirror.person_id }
      end

    end

    def new
      @mirror = Mirror.new

      respond_to do |format|
        format.html { render 'new' }
        format.js {}
      end

    end

    def edit
      @mirror = Mirror.find(params[:id])
    end

    def create
      @user = User.find(current_user)
      @mirror = Mirror.new(name: params[:name], owner_id: @user.id, email: @user.email, password_digest: params[:password])

      if @mirror.save

        respond_to do |f|
          f.html { redirect_to :back }
          f.js {}
        end

      else
        render 'new'
      end

    end

    def update
      @user = User.find(params[:user_id])
      @person_id = @user.person_id
      @mirror = Mirror.find(params[:id])

      @mirror.update(person_id: @person_id)
      
      redirect_to user_mirror_path(@user, @mirror)
    end

    def destroy
      @mirror = Mirror.find(params[:id])
      @mirror.update(person_id: nil)

      respond_to do |format|
       format.html { render json: { response: 'success' } }
      end

    end

end