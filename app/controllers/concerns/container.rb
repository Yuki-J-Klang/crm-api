require 'yaml'
require 'json'
module Container
    def get_ports_from_docker_compose(file_path)
        begin
            docker_compose_data = YAML.load_file(file_path)
            services = docker_compose_data['services']

            services.each do |service_name, service_config|
                ports = service_config['ports']
                get_public_ip_address = "docker node inspect self --format '{{ .Status.Addr  }}'"
                address = system(get_public_ip_address)
                public_ip_address = { result: address }.to_json
                render json: {
                    resalt: "Service: #{service_name}, Ports: #{ports.join(', ')}" ,public_ip_address
                }if ports
            end
        rescue StandardError => e
            render json: { message: 'Get information Failed', status: 500 }
        end
    end

    module_function :get_ports_from_docker_compose

    private
    # ファイルのパスを指定して関数を呼び出し
    get_ports_from_docker_compose('/path/to/docker-compose.yml')
end