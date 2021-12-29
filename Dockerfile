FROM node:12.14.0 as node
FROM ruby:3.0.1
RUN apt-get update -qq && apt-get install -y nodejs sqlite3 libsqlite3-dev yarn chromium-driver locales

COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/include/node /usr/local/include/node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN ln -s /usr/local/bin/node /usr/local/bin/nodejs && \
    ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

ENV YARN_VERSION 1.21.1

COPY --from=node /opt/yarn-v$YARN_VERSION /opt/yarn
COPY --from=node /usr/local/bin/node /usr/local/bin/

RUN ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
    && ln -s /opt/yarn/bin/yarnpkg /usr/local/bin/yarnpkg

WORKDIR /Amica
COPY Gemfile /Amica/Gemfile
COPY Gemfile.lock /Amica/Gemfile.lock
RUN gem install bundler
RUN bundle install --without production
RUN yarn install
COPY . /Amica

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

RUN locale-gen ja_JP.UTF-8
RUN apt-get install -y tzdata \
  && rm /etc/localtime \
  && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
  && dpkg-reconfigure -f noninteractive tzdata
RUN rm -rf /var/lib/apt/lists/*

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
