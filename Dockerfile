FROM centurylink/alpine-rails

ENV APP_HOME /umpire-auditor
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME

EXPOSE 3000
ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "s", "-b", "0.0.0.0", "-p", "3000"]
