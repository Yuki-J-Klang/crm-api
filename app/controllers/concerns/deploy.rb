requier 'json'

module Deploy
    def deploy
      deploy_command = "docker stack deploy -c #{Rails.root}/docker-compose.yml #{file_name}"
      success = system(deploy_command)
  
      if success
        save_deployment_info
        render json: { 'Deployment successful' }
      else
        render json: { 'Deployment failed', status: 500 }
      end
    end
  
    private
  
    def save_deployment_info
      service_name = `docker service ls --filter "name=#{file_name}" --format "{{.Name}}"`
      Deployment.create(service_name: service_name)
    end
end
