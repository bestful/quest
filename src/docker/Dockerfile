FROM mcr.microsoft.com/dotnet/core/sdk:2.1 AS build-env

# Setup NodeJs
RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y gnupg2 && \
    wget -qO- https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y build-essential nodejs
# End setup

# Making project our workdir
WORKDIR /youtube-app

# Copy everything else and build
ADD ./web.tar .

WORKDIR ./angular
RUN npm install

WORKDIR ../webapi

RUN dotnet restore
RUN dotnet publish -c Release -o ../out

WORKDIR ../out
ENTRYPOINT ["dotnet", "webapi.dll"]