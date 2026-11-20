# DevOps Practical

A Flutter Web application used to practice version control, CI, Docker,
Kubernetes, and continuous deployment. The existing quality gate runs Flutter
tests and produces a release web build in GitHub Actions.

## Local development

Install the Flutter stable SDK, then run:

```shell
flutter pub get
flutter test
flutter run -d chrome
```

The home page initially displays `Hello, DevOps World! V1`.

## GitHub Actions

`.github/workflows/ci.yml` runs on pushes to `main`. It checks out the source,
installs Flutter stable, runs `flutter test`, and builds the release web app.
Push a commit to `main` and verify the run in the repository's **Actions** tab.

## Build and run the Docker image

The Dockerfile builds the Flutter web assets and serves them with Nginx. Nginx
uses the `PORT` environment variable provided by platforms such as Render, and
defaults to port 80 for local and Kubernetes use.

```shell
docker build -t devops-practical:v1 .
docker run --rm -p 5000:80 devops-practical:v1
```

Open <http://localhost:5000> to verify the app. Stop it with `Ctrl+C`.

To publish to Docker Hub, replace `YOUR_DOCKERHUB_USERNAME` with your account:

```shell
docker login
docker tag devops-practical:v1 YOUR_DOCKERHUB_USERNAME/devops-practical:v1
docker push YOUR_DOCKERHUB_USERNAME/devops-practical:v1
```

## Deploy to Kubernetes

Install `kubectl` and Minikube, start a local cluster, and update the image
field in `k8s/deployment.yaml` to the Docker Hub image you pushed:

```shell
minikube start --driver=docker
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl get pods -w
```

Wait for both replicas to become ready, then open the service:

```shell
minikube service devops-practical
```

To demonstrate self-healing, delete one pod returned by `kubectl get pods`.
The Deployment will create a replacement to restore the desired replica count.

## Deploy to Render

Create a Render **Web Service** connected to this GitHub repository and select
the Docker runtime. Configure auto-deploy to wait for CI checks to pass.
Render supplies a `PORT`; the container's Nginx template uses that value, with
port 80 as the local default.

After the service is live, change the text in `lib/main.dart` and its expected
text in `test/widget_test.dart`, for example to
`CI/CD and Docker Pipeline is a massive success! V2`. Run `flutter test`, then
commit and push to `main`. GitHub Actions verifies the change, and Render
deploys it after the checks pass.
