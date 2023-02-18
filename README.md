# lucid-runner

A CI/CD runner based on Docker API and RabbitMQ.

> The project is not yet functional!

---

This project contains the Ruby code of the "runner" brick of the Lucid project. Lucid is a CI/CD tool currently under development by Mapstring, a French software development company.

We decided to open the development of the runner to the GitHub community in order to improve its quality and to allow its intensive testing.

## Security

Do not hesitate to contact us at security/at/mapstring/dot/com if you find any security issue.

## Development

```
git clone git@github.com:apkiq/lucid-runner.git
cd lucid-runner
bundler install -j4
bundler exec ruby app.rb
```
