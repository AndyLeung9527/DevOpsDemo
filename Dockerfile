FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["src/DevOpsDemo.Web/DevOpsDemo.Web.csproj","DevOpsDemo.Web/"]
RUN dotnet restore "DevOpsDemo.Web/DevOpsDemo.Web.csproj"
COPY . .
WORKDIR /src/DevOpsDemo.Web
RUN dotnet build "DevOpsDemo.Web.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DevOpsDemo.Web.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish
ENTRYPOINT ["dotnet","DevOpsDemo.Web.dll"]