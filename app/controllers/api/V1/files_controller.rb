class Api::V1::FilesController < ApplicationController
  include Deploy
  include Container

  def launch
    # json_data = JSON.parse(request.body.read)
    # folder_name = json_data['folder_name']
    # フォルダの存在チェック
    if Dir.exist?(folder_params)
      # そのフォルダへディレクトリ移動
      move_to_directory(folder_params)
      # folder_nameでDocker Swarmにデプロイ
      Deploy.deploy_service(folder_params)
      # port番号、指定ノード先のIpアドレス取得
      Container.launch_container
      Container.get_ports_from_docker_compose("#{Rails.root}/docker-compose.yml")
      render json: { message: "起動しました。", status: 200 }
    else
      render json: { message: folder_params, status: 500 }
    end
  end
    
  private

  def folder_params
    #リクエストbodyからfile_nameをjsonで受け取る
    params.permit(:scenario_name)
  end

  def move_to_directory(folder_name)
    Dir.chdir(folder_name)
  end
end