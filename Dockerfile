FROM ruby:slim-bullseye
# install common lib
RUN apt-get update && apt-get -y upgrade &&\
    apt-get -y install aptitude -y gnupg wget curl vim unzip zip git
# install build lib
RUN aptitude install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev libpq-dev postgresql
# install rbenv
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
ENV PATH /root/.rbenv/shims:/root/.rbenv/bin:$PATH
# install ruby
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build && \
    ~/.rbenv/bin/rbenv install 3.1.1 && \
    ~/.rbenv/bin/rbenv global 3.1.1
# install gem
RUN ~/.rbenv/bin/rbenv exec gem install bundler rails pg
# make dir share folder for code
RUN mkdir -p /root/projects
