task :up do
  exec('sudo docker-compose up')
end

task :down do
  exec('sudo docker-compose down')
end

task :clean do
  exec('sudo scripts/clean.sh')
end

task :setup do
  exec('sudo docker-compose exec vault /scripts/setup.sh')
end

task :seed do
  exec('sudo docker-compose exec vault /scripts/seed.sh')
end

task :unseal do
  exec ('sudo docker-compose exec vault /scripts/unseal.sh')
end
