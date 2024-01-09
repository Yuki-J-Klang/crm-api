class Api::V1::FilesController < ApplicationController
    include Deploy
    include Container

    def launch_container
        file_name = file_params
        # ファイルの存在チェックを行うメソッドを呼び出す
        file_path = Rails.root.join('path_to_your_directory', file_name)
        if File.exist?(file_path)
          move_to_directory(file_path)
          Deploy.deploy_service(file_name)
          Container.get_ports_from_docker_compose(" #{Rails.root}/docker-compose.yml ")
        else
          render json: { message: "File not found." }
        end
      end
    
      private
      def file_params
        # リクエストbodyからfile_nameをjsonで受け取る
        params.permit(:file_name)
      end

      def move_to_directory(file_path)
        # 移動先のディレクトリを指定
        destination_directory = Rails.root.join('path_to_destination_directory')
        # FileUtilsを使用してファイルを移動
        FileUtils.mv(file_path, destination_directory)
      end
end