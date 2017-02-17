FROM ubuntu:16.04

# Install some packages
RUN apt-get update && apt-get install -y build-essential openjdk-8-jdk unzip wget

# Setup the user
ENV USERNAME squirrel
RUN useradd -ms /bin/bash $USERNAME
USER $USERNAME
WORKDIR /home/$USERNAME

# Download and extract torquebox
ENV TORQUEBOX_VERSION 3.2.0
RUN wget http://torquebox.org/release/org/torquebox/torquebox-dist/$TORQUEBOX_VERSION/torquebox-dist-$TORQUEBOX_VERSION-bin.zip -P ~
RUN unzip ~/torquebox-dist-$TORQUEBOX_VERSION-bin.zip -d ~

# Set the environment variables
ENV TORQUEBOX_HOME /home/$USERNAME/torquebox-$TORQUEBOX_VERSION
ENV JBOSS_HOME $TORQUEBOX_HOME/jboss
ENV JRUBY_HOME $TORQUEBOX_HOME/jruby
ENV PATH $JRUBY_HOME/bin:$PATH
# RUN chmod +x $TORQUEBOX_HOME/jboss/bin/*.sh

# Copy over the rails app, set permissions and the working directory
RUN mkdir dockerailsbox
COPY . dockerailsbox
USER root
RUN chown -R $USERNAME:$USERNAME /home/$USERNAME/dockerailsbox
USER $USERNAME
WORKDIR dockerailsbox

# Install the gems
RUN gem install bundler && bundle install

# Deploy the app on torquebox
RUN torquebox deploy

# Expose the ports we care about
EXPOSE 8080 9990

# Set the initial command to run
CMD ["/home/squirrel/torquebox-3.2.0/jboss/bin/standalone.sh", "-b", "0.0.0.0"]
