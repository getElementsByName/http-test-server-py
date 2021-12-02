
RELEASE_NAME=http-test-server
COMMON_OPTIONS=--values=values.yaml
ADDITIONAL_OPTIONS=

cluster.set.development.ad1:
	ncc cluster set pai-playground@ad1
cluster.set.staging.cr1:
	ncc cluster set pai-staging@cr1
cluster.set.production.cr1:
	ncc cluster set pai@cr1

HELM_CLI=/usr/bin/helm
HELM_CLI=/usr/local/bin/helm
# HELM_CLI=ncc helm
deploy.development: cluster.set.development.ad1
	$(HELM_CLI) upgrade --install $(COMMON_OPTIONS) $(RELEASE_NAME) ./
deploy.staging: cluster.set.staging.cr1
	$(HELM_CLI) upgrade --install $(COMMON_OPTIONS) $(RELEASE_NAME) ./


## sample code
delete:
	$(HELM_CLI) delete $(RELEASE_NAME)

expose:
	kubectl expose deployment/${RELEASE_NAME} --name gateway-$(RELEASE_NAME) --type LoadBalancer