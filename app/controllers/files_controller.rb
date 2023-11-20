class FilesController < ApplicationController
    def check_file_existence
        json_data = JSON.parse(request.body.read)
        file_name = json_data['file_name']
    
        # ファイルの存在チェックを行うメソッドを呼び出す
        result = check_file_existence_locally(file_name)
    
        render json: { exists: result }
    end
    
    private
    
    def check_file_existence_locally(file_name)
        # ローカルディレクトリ内にファイルが存在するか確認するロジックを追加
        File.exist?(Rails.root.join('path_to_your_directory', file_name))
    end
end