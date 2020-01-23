1. ELK Setup
    1. install
        
        ```bash 
            git clone https://github.com/deviantony/docker-elk.git
            cd docker-elk
            docker-compose build
            docker-compose up -d # or docker-compose up --build -d 
            docker-compose logs -f
        ```
        
    2. config password
        
        ```bash
            $ docker-compose exec -T elasticsearch bin/elasticsearch-setup-passwords auto --batch
            Changed password for user apm_system
            PASSWORD apm_system = MLvlkWhJcJBsKZLitEWy
            
            Changed password for user kibana
            PASSWORD kibana = BmBRpoph2AqW56A2r9wN
            
            Changed password for user logstash_system
            PASSWORD logstash_system = r2tGW6g8gxmnm4HA5aKf
            
            Changed password for user beats_system
            PASSWORD beats_system = kOrNuDlvN0I5sDisssIK
            
            Changed password for user remote_monitoring_user
            PASSWORD remote_monitoring_user = 4S5s6NShc8uZIbvqFeRk
            
            Changed password for user elastic
            PASSWORD elastic = x3YUJobRIE5y88x5B8nA
        ```

        ```bash
            docker-compose.yml              # Change 'changeme' to your new Password 
            kibana/config/kibana.yml        # Change 'changeme' to your new Password 
            logstash/config/logstash.yml    # Change 'changeme' to your new Password
            logstash/pipeline/logstash.conf # Change 'changeme' to your new Password
            docker-compose restart kibana logstash # or docker-compose restart
            
            curl -XPOST -D- 'http://localhost:5601/api/saved_objects/index-pattern' \
                -H 'Content-Type: application/json' \
                -H 'kbn-version: 7.5.1' \
                -u elastic:x3YUJobRIE5y88x5B8nA \
                -d '{"attributes":{"title":"logstash-*","timeFieldName":"@timestamp"}}'
        ```
        
        ```bash
            $ cat kibana/config/kibana.yml
            ---
            ## Default Kibana configuration from Kibana base image.
            ## https://github.com/elastic/kibana/blob/master/src/dev/build/tasks/os_packages/docker_generator/templates/kibana_yml.template.js
            #
            server.name: kibana
            server.host: "0"
            elasticsearch.hosts: [ "http://elasticsearch:9200" ]
            xpack.monitoring.ui.container.elasticsearch.enabled: true
            
            ## X-Pack security credentials
            #
            elasticsearch.username: elastic
            elasticsearch.password: x3YUJobRIE5y88x5B8nA
        ```
        > http://http://localhost:5601/
        > login with id : elastic, pw : x3YUJobRIE5y88x5B8nA (or your new Password)
                
    3. disable xpack
    
        https://github.com/deviantony/docker-elk#how-to-disable-paid-features
        ```bash
            # elasticsearch/config/elasticsearch.yml
            xpack.license.self_generated.type: basic
        ```
    4. logstash.conf
        
        ```bash
            # logstash/pipeline/logstash.conf
            input {
              udp {
                host => "0.0.0.0"
                port => 5000
                codec => json_lines
              }
            }
            
            ## Add your filters / logstash plugins configuration here
            
            output {
              elasticsearch {
                hosts => ["elasticsearch:9200"]
                user => "elastic"
                password => "7tG59gLU9keX0CT1S9vI"
                codec => json_lines
              }
              stdout {
                codec => json_lines
              }
            }
        ```
    5. docker-compose.yml
        we will use UDP. you have to change "5000:5000" to "5000:5000/udp" in logstash port
        ```yml
            version: '3.2'
            
            services:
              elasticsearch:
                build:
                  context: elasticsearch/
                  args:
                    ELK_VERSION: $ELK_VERSION
                volumes:
                  - type: bind
                    source: ./elasticsearch/config/elasticsearch.yml
                    target: /usr/share/elasticsearch/config/elasticsearch.yml
                    read_only: true
                  - type: volume
                    source: elasticsearch
                    target: /usr/share/elasticsearch/data
                ports:
                  - "9200:9200"
                  - "9300:9300"
                environment:
                  ES_JAVA_OPTS: "-Xmx256m -Xms256m"
                  ELASTIC_PASSWORD: 7tG59gLU9keX0CT1S9vI
                networks:
                  - elk
            
              logstash:
                build:
                  context: logstash/
                  args:
                    ELK_VERSION: $ELK_VERSION
                volumes:
                  - type: bind
                    source: ./logstash/config/logstash.yml
                    target: /usr/share/logstash/config/logstash.yml
                    read_only: true
                  - type: bind
                    source: ./logstash/pipeline
                    target: /usr/share/logstash/pipeline
                    read_only: true
                ports:
                  - "5000:5000/udp"
                  - "9600:9600"
                environment:
                  LS_JAVA_OPTS: "-Xmx256m -Xms256m"
                networks:
                  - elk
                depends_on:
                  - elasticsearch
            
              kibana:
                build:
                  context: kibana/
                  args:
                    ELK_VERSION: $ELK_VERSION
                volumes:
                  - type: bind
                    source: ./kibana/config/kibana.yml
                    target: /usr/share/kibana/config/kibana.yml
                    read_only: true
                ports:
                  - "5601:5601"
                networks:
                  - elk
                depends_on:
                  - elasticsearch
            
            networks:
              elk:
                driver: bridge
            
            volumes:
              elasticsearch:
        ```
