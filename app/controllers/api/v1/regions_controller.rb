class Api::V1::RegionsController < Api::V1::ApiController
  def create
    region = Region.create(create_params)
    render json: region, each_serializer: RegionSerializer, status: :created
  end

  def index
    regions = Region.all
    render json: regions, each_serializer: RegionSerializer, status: :ok
  end

  def show
    region = Region.find params[:id]
    render json: region, each_serializer: RegionSerializer, status: :ok
  end

  def update
    region = Region.find params[:id]
    region.update_attributes(update_params)
    render json: region, each_serializer: RegionSerializer, status: :accepted
  end

  def destroy
    region = Region.find params[:id]
    region.destroy
    render json: {}, status: :accepted
  end

  private

  def update_params
    params.permit(:name, :abbreviation, :time_zone, :admin_notes, :archived, :test)
  end

  def create_params
    params.permit(:name, :abbreviation, :time_zone, :admin_notes, :archived, :test)
  end
end
