FROM python:3.11

# create the app user
RUN addgroup --system app && adduser --system --ingroup app --home /home/app --shell /bin/sh --disabled-password app

# create the appropriate directories
ENV HOME=/home/app
ENV APP_HOME=/home/app/web
RUN mkdir $APP_HOME
# Setup empty ~/.ssh directory
RUN mkdir $HOME/.ssh
WORKDIR $APP_HOME

# copy project
COPY . $APP_HOME

# chown all the files to the app user
RUN chown -R app:app $APP_HOME && chown -R app:app $HOME/.ssh && chmod 700 $HOME/.ssh

# change to the app user
USER app

# Verify write access to the .ssh folder
RUN touch $HOME/.ssh/foobar.txt

# Collect static files
CMD ["/bin/bash", "python3 -m http.server"]
