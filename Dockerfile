FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ./${{ env.PROJECT_NAME }} ./${{ env.PROJECT_NAME }}
WORKDIR /src/${{ env.PROJECT_NAME }}
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "${{ env.PROJECT_NAME }}.dll"]
