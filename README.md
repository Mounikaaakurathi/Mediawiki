# Mediawiki
Helm chart for mediawiki to deploy on kubernetes

#Pre-requisites
 A Kubernetes cluster on cloud. You can also run a minikube or docker for windows desktop, Helm and kubectl
versions installed on my machine .
kubernetes v1.27.9
helm v3.8.2
docker image : Here I have Used images I have created and pushed to my private ACR (mwikiacr.azurecr.io/test/mariadb-image-isha)
How to run
The repo conatines two charts .

1.) mediawiki-chart runs mediawiki app
2.) mediawiki-mariadb-chart runs database for mediawiki app.

To deploy, hop over to the chart and execute below command

helm install chartname /directory

example > helm install mediawiki ./mediawiki-chart and helm install database ./mediawiki-mariadb-chart

The application will be served on the external ip provided by load balancer . In my case it was > http://<publicIP>:80. The databse host will be available at <PublicIP>:3306. Set the db root password, username and db name from values file placed inside mediawiki-mariadb-chart . Use the same to configure mediawiki db details page .

At the end of configuartion , LocalSettings.php will be downloaded . The same file need to be placed at /var/www/mediawiki inside conatiner . This can be done by removing commented hostmount in deployment.yaml of mediawiki-chart and providing a hostmount path.
