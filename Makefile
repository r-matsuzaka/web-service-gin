IMAGE = asia-northeast1-docker.pkg.dev/`gcloud config get-value project`/cloud-run/web-servie-gin

build:
	pack build web-service-gin --builder gcr.io/buildpacks/builder	

tag:
	docker image tag web-service-gin $(IMAGE)

push:
	docker image push $(IMAGE)

deploy:
	gcloud run deploy web-service-gin \
		--image $(IMAGE) \
		--region asia-northeast1 \
		--platform managed \
		--allow-unauthenticated

staging: build tag push deploy

delete:
	gcloud run services delete web-service-gin \
		--region asia-northeast1 \
		--platform managed