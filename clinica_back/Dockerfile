# Use the official .NET SDK image to build the application
# This image includes everything needed to build the .NET application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /app
# Create a new directory inside /app
RUN mkdir Clinica.Api
RUN mkdir Clinica.Dominio
RUN mkdir Clinica.Infraestructura.Datos
RUN mkdir Clinica.Infraestructura.Transversal

# Copy the csproj file and restore dependencies
COPY /Clinica.Api/*.csproj ./Clinica.Api
COPY /Clinica.Dominio/*.csproj ./Clinica.Dominio
COPY /Clinica.Infraestructura.Datos/*.csproj ./Clinica.Infraestructura.Datos
COPY /Clinica.Infraestructura.Transversal/*.csproj ./Clinica.Infraestructura.Transversal
COPY /Clinica.Tests.UnitTests/*.csproj ./Clinica.Tests.UnitTests

RUN dotnet restore ./Clinica.Api/Clinica.Api.csproj

# Copy the rest of the application source code
COPY /Clinica.Api/. ./Clinica.Api
COPY /Clinica.Dominio/. ./Clinica.Dominio
COPY /Clinica.Infraestructura.Datos/. ./Clinica.Infraestructura.Datos
COPY /Clinica.Infraestructura.Transversal/. ./Clinica.Infraestructura.Transversal
RUN rm -rf /app/Clinica.Tests.UnitTests
COPY Clinica.Tests.UnitTests/. ./Clinica.Tests.UnitTests

WORKDIR /app/Clinica.Api
# Build the application
RUN dotnet build -c Release -o /app/build

# Publish the application
RUN dotnet publish -c Release -o /app/publish

# Use the official .NET Runtime image for the final image
# This image is smaller and includes only what's needed to run the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

# Set the working directory in the container
WORKDIR /app

# Copy the published application from the build stage
COPY --from=build /app/publish .

# Install EF tools
# RUN dotnet tool install --global dotnet-ef

# ENV PATH="$PATH:/root/.dotnet/tools"
# Expose the port the app will run on
# HTTP
EXPOSE 5146

ENTRYPOINT ["dotnet", "Clinica.Api.dll"]