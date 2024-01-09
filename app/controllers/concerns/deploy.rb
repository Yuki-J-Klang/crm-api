require 'json'
module Deploy
  def deploy_service(folder_name)
    deploy_command = "docker stack deploy -c #{Rails.root}/docker-compose.yml #{folder_name}"
    success = system(deploy_command)
    if success
      # save_deployment_info
      render json: { message: 'Deployment successful' }
    else
      render json: { message: 'Deployment failed', status: 500 }
    end
  end
    
  module_function :deploy_service

  private
  # データベースにデプロイ時の名前保存
  # def save_deployment_info
  #   service_name = `docker service ls --filter "name=#{file_name}" --format "{{.Name}}"`
  #   Deployment.create(service_name: service_name)
  # end
end
