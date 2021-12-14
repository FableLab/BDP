class QrcodesController < ApplicationController
  def show
    code_number = params[:slug].split('-')[4]
    @resource = Resource.find_by_code_number(code_number)

    qrcode_url = resource_url(slug: @resource.slug)
    qrcode_file_path = "#{Dir.mktmpdir}/#{@resource.qrcode_filename}"
    qrcode_file = RQRCode::QRCode.new(qrcode_url).as_png(size: 180, border_modules: 0)
    IO.binwrite(qrcode_file_path, qrcode_file.to_s)

    send_file(qrcode_file_path)
  end

  def index
    @resources = Resource.where(id: critera_params[:ids])

    temp_dir = Dir.mktmpdir
    zip_file_path = "#{temp_dir}/qrcodes-#{SecureRandom.hex(8)}.zip"

    Zip::File.open(zip_file_path, Zip::File::CREATE) do |zipfile|
      @resources.each do |resource|
        qrcode_url = resource_url(slug: resource.slug)
        qrcode_file_path = "#{temp_dir}/#{resource.qrcode_filename}"
        qrcode_file = RQRCode::QRCode.new(qrcode_url).as_png(size: 180, border_modules: 0)
        IO.binwrite(qrcode_file_path, qrcode_file.to_s)

        zipfile.add(resource.qrcode_filename, qrcode_file_path)
      end
    end

    send_file(zip_file_path)
  end

  private

  def critera_params
    params.permit(ids: [])
  end
end
