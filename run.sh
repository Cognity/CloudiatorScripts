docker build -t my-apache2 .
echo "Build finished, Starting Docker run"
docker run -dit --name apache -p 8081:80 my-apache2
