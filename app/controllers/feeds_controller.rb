class FeedsController < ApplicationController
  # GET /feeds
  # GET /feeds.json
  def index
    @user = current_user
    @feeds = @user.feeds

    @feeds.each do |feed|
      Feed.check_for_update(feed)
    end

    gon.feed = @feeds
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
    @feed = Feed.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feed }
    end
  end

  # GET /feeds/new
  # GET /feeds/new.json
  def new
    @feed = Feed.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feed }
    end
  end

  # GET /feeds/1/edit
  def edit
    @feed = Feed.find(params[:id])
  end

  # POST /feeds
  # POST /feeds.json
  def create
    # @feed = Feed.new(params[:feed])
    # @feed = user.feed.build(params[:feed])

    @user = current_user
    @feed = @user.feeds.build(params[:feed])

    @feed.fetch_feed!

    respond_to do |format|
      if @feed.save
        format.html { redirect_to "/", notice: 'Feed was successfully created.' }
        format.json { render json: @feed, status: :created, location: @feed }
      else
        format.html { render action: "new" }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /feeds/1
  # PUT /feeds/1.json
  def update
    @feed = Feed.find(params[:id])

    respond_to do |format|
      if @feed.update_attributes(params[:feed])
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to feeds_url }
      format.json { head :no_content }
    end
  end

  def visit_feed
    @feed = Feed.find(params[:id])
    @feed.update_visit_date!

    respond_to do |format|
      format.html
    end
  end
end
