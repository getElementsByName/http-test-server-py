
RELEASE_NAME=http-test-server
COMMON_OPTIONS=--values=values.yaml
ADDITIONAL_OPTIONS=

cluster.set.development.ad1:
	ncc cluster set pai-playground@ad1
cluster.set.production.crg1:
	ncc cluster set pdp-ml@crg1
cluster.set.production.cr1:
	ncc cluster set pdp-ml@cr1

HELM_CLI=/usr/bin/helm
# HELM_CLI=ncc helm
deploy.development: cluster.set.development.ad1
	$(HELM_CLI) upgrade --install $(COMMON_OPTIONS) $(RELEASE_NAME) ./
deploy.production: cluster.set.production.cr1
	$(HELM_CLI) upgrade --install $(COMMON_OPTIONS) $(RELEASE_NAME) ./


## sample code
delete:
	$(HELM_CLI) delete $(RELEASE_NAME)

expose:
	kubectl expose deployment/${RELEASE_NAME} --name gateway-$(RELEASE_NAME) --type LoadBalancer