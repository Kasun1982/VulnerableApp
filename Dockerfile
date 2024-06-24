# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app

# Copy everything and build
COPY . ./
RUN dotnet restore
RUN dotnet build -c Release -o out

# Use the official ASP.NET image to run the app
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build-env /app/out .

# Expose port 80
EXPOSE 80

# Entry point
ENTRYPOINT ["dotnet", "VulnerableApp.dll"]
