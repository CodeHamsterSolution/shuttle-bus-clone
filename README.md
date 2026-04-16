# MMU Shuttle Bus - Deployment Guide

This guide covers the deployment instructions for the MMU Shuttle Bus platform on an Ubuntu/Debian-based server.

## 1. Domain Registration and DNS Setup
First, spin up a server instance and ensure domain records (e.g., `kasheng.me` and `www.kasheng.me`) point to the server's public IP address.

## 2. Generate SSL Certificates (Certbot)

Update the package index and install Certbot:
```bash
sudo apt update
sudo apt install certbot -y
```

Run Certbot strictly in standalone mode to generate production SSL certificates:
```bash
sudo certbot certonly --standalone \
  -d kasheng.me \
  -d www.kasheng.me \
  --email kashengow@gmail.com \
  --agree-tos \
  --no-eff-email
```
> **Note:** Ensure ports 80 and 443 are free and not actively in use by any web servers when running standalone mode.

## 3. Clone the Repository

Install Git:
```bash
sudo apt update
sudo apt install git -y
```

Clone the application repository and navigate into the root directory:
```bash
git clone https://github.com/JasonOw718/MMU_Shuttle_Bus_Version2.git
cd MMU_Shuttle_Bus_Version2
```

## 4. Setting Up Environment Variables

Prepare the environment files. Run the following command to automatically generate the `.env` file at the root of the project with all necessary variables:

```bash
touch .env
cat <<EOF > .env
DB_USERNAME=<db_admin_username>
DB_PASSWORD=<db_admin_password>
PG_USERNAME=<pgadmin_email>
PG_PASSWORD=<pgadmin_password>
STORAGE_URL=/opt/files/
JWT_SECRET=<jwt_secret_key>
VITE_GOOGLE_MAPS_API_KEY=<google_maps_api_key>
VITE_GOOGLE_MAPS_ID=<google_maps_map_id>
VITE_API_URL=https://<domain_name>/api
VITE_WEB_SOCKET_URL=https://<domain_name>/ws-endpoint
EOF
```

> **Note on Storage:** Make sure the server grants the necessary read/write permissions to the `STORAGE_URL` path (`/opt/files/`) for image uploads.

## 5. Install Docker & Docker Compose

If Docker isn't already installed on the server, follow the official Ubuntu guides:
- [Install Docker Engine](https://docs.docker.com/engine/install/ubuntu/)
- [Install Docker Compose](https://docs.docker.com/compose/install/)

## 6. Build and Spin Up the Server

Spin up the entire stack using Docker Compose. Nginx will automatically pick up the SSL certificates generated in Step 2:
```bash
sudo docker compose -f docker-compose-prod.yml up -d --build
```

## 7. Post-Deployment Steps

For the application functionality to work smoothly, the database must be seeded.

Access the pgAdmin console using the configured credentials:
- **Email:** `<pgadmin_email>`
- **Password:** `<pgadmin_password>`

Connect to the Postgres database and run the `insert_value.sql` script to populate base records like routes, stations, and users.
