FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY /src/DevOpsDemo.Web/DevOpsDemo.Web.csproj ./DevOpsDemo.Web/
RUN dotnet restore ./DevOpsDemo.Web/DevOpsDemo.Web.csproj
COPY /src/DevOpsDemo.Web ./DevOpsDemo.Web/
WORKDIR /src/DevOpsDemo.Web
RUN dotnet publish -c Release -o /publish --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
ENV ASPNETCORE_HTTP_PORTS=80
#ENV ASPNETCORE_HTTPS_PORTS=443
LABEL author=LWB
WORKDIR /app
COPY --from=build /publish .
EXPOSE 80
#EXPOSE 443
ENTRYPOINT ["dotnet","DevOpsDemo.Web.dll"]