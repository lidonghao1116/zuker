class PicturesController < ApplicationController
# truncated for brevity.
  def create
    @picture = Picture.new(picture_params)
    @picture.save
  end

private
  def picture_params
    params.require(:pictures).permit(:file_name, :image)
  end
end