# Utiliza una imagen base de Ubuntu
FROM ubuntu:latest

# Actualiza el sistema y instala las dependencias necesarias
RUN apt-get update && apt-get upgrade -y && apt-get install -y software-properties-common wget

# Agrega el repositorio de Grafana y la clave GPG
RUN add-apt-repository "deb https://packages.grafana.com/oss/deb stable main" && \
    wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -

# Instala Grafana
RUN apt-get update && apt-get install -y grafana

# Expone el puerto 3000 para acceder a Grafana
EXPOSE 3000

# Comando para iniciar Grafana en modo daemon
CMD /usr/sbin/grafana-server --config=/etc/grafana/grafana.ini --homepath=/usr/share/grafana --packaging=deb cfg:default.paths.logs=/var/log/grafana cfg:default.paths.data=/var/lib/grafana cfg:default.paths.plugins=/var/lib/grafana/plugins
