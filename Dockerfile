FROM python:3.7-slim@sha256:ad0adc0460e66f79ee604262a1083e3a0b62c1adae5d08fa5084b7eb4d1e1444

WORKDIR /usr/src/app

COPY requirements.txt ./

RUN pip install -q --no-cache-dir -r requirements.txt

ENV TERRAFORM_VERSION='0.12.6' \
	TERRAFORM_SHA256SUM=6544eb55b3e916affeea0a46fe785329c36de1ba1bdb51ca5239d3567101876f \
	TF_IN_AUTOMATION=true \
	TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"

RUN apt-get update && apt-get install --no-install-recommends -y \
		curl \
		git \
		make \
		unzip \
		zip \
	&& curl -sSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
	&& echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS \
	&& sha256sum -c --status terraform_${TERRAFORM_VERSION}_SHA256SUMS \
	&& unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin \
	&& rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&& apt-get autoremove --purge -y \
		curl \
		unzip

CMD ["/bin/terraform", "help"]
