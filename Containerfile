FROM python:3-alpine AS builder

RUN pip install poetry

COPY . /tmp/toml_cli

WORKDIR /tmp/toml_cli

RUN poetry build

RUN tar -zxvf /tmp/toml_cli/dist/toml_cli-*.tar.gz


FROM python:3-alpine

COPY --from=builder /tmp/toml_cli/toml_cli-0.4.0 /tmp/toml_cli-0.4.0

WORKDIR /tmp/toml_cli-0.4.0

RUN python setup.py install

ENTRYPOINT [ "toml" ]