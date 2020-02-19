FROM ruby:2.6.3

RUN echo "Australia/Sydney" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      curl \
      libpq-dev \
      libmagickcore-dev \
      libmagickwand-dev \
      imagemagick \
      nodejs

RUN gem install bundler  -v '2.1.1' --no-document

# Add the wait-for-it.sh script for waiting on dependent containers
RUN curl https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /usr/local/bin/wait-for-it.sh \
  && chmod +x /usr/local/bin/wait-for-it.sh

# for bower-rails
RUN npm install bower@1.8 -g
# allow bower to run as root
RUN echo '{ "allow_root": true }' > ~/.bowerrc

# Rubygems and Bundler
WORKDIR /app/
COPY Gemfile* /app/

ARG BUNDLE_WITHOUT=test:development
ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}

RUN bundle config --global github.https true
RUN bundle install -j $(nproc) --retry 5

COPY . /app/

CMD ["bundle exec rails"]
