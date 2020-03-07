# configure GCP and setup a N1 cluster

#configure gcloud
gcloud init
gcloud auth configure-docker
gcloud config set project pikachu-270405

# modify package.json with your GCP project ID, i.e. replace "pikachu-270405" with your project id 
npm install
npm run docker:build
npm run docker:push

kubectl create -f deploy.yml

# reserve a static IP
gcloud compute addresses create pikachu
gcloud compute addresses list
# copy static address to loadBalancerIP in loadbalancer.yml

kubectl create -f loadbalancer.yml

# create an A record to map domain pikachu.<your-domain>.<tld> to load balancer's static IP
