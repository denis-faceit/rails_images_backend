class Api::ArchivesController < ApplicationController
  before_action :set_archive, only: [:show]

  def index
    @archives = Archive.archives_data.page(params[:page]).per(12).without_count
    .includes(image_attachment: :blob)
    fetch_response
  end

  def show
    render json: @archive, serializer: ArchiveShowSerializer
  end

  def create
    @archive = current_user.archives.new(archive_params)

    if @archive.save
      render json: @archive, status: :created
    else
      render json: @archive.errors, status: :unprocessable_entity
    end
  end

  def search
    @archives = Archive.archives_data.search_archives(params[:search]).page(params[:page]).per(12).without_count
    .includes(image_attachment: :blob)
    fetch_response
  end

  private

  def fetch_response
    render json: {
      images: ActiveModel::Serializer::CollectionSerializer.new(@archives, each_serializer: ArchiveSerializer),
      next_page_url: @archives.next_page,
      prev_page_url: @archives.prev_page
    }
  end

  def set_archive
    @archive = Archive.archives_data.uploaded_by.find_by_token(params[:token])
  end

  def archive_params
    params.require(:archive).permit(:name, :image)
    .with_defaults(token: Digest::MD5.hexdigest(Time.now.to_s + params[:archive][:name]))
  end
end
