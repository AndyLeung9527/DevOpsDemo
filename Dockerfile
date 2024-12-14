FROM mcr.microsoft.com/dotnet/sdk:9.0
WORKDIR /src
COPY ./src .
RUN dotnet publish DevOpsDemo.Web/DevOpsDemo.Web.csproj -c Release -o /publish
FROM mcr.microsoft.com/dotnet/aspnet:9.0
LABEL author=LWB
WORKDIR /app
COPY --from=0 /publish .
EXPOSE 80
EXPOSE 443
ENTRYPOINT ["dotnet","DevOpsDemo.Web.dll"]