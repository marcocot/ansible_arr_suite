# arr_suite Ansible Role with Traefik

[![ansible-lint](https://github.com/marcocot/ansible_arr_suite/actions/workflows/lint.yaml/badge.svg)](https://github.com/marcocot/ansible_arr_suite/actions/workflows/lint.yaml)

Welcome to the ultimate Ansible role for setting up the *arr suite (Radarr, Sonarr, and more) using Docker and Traefik as the reverse proxy. This role automates the whole process, so you can spend less time configuring and more time managing your media!

## What's Included?

This role takes care of:
* Deploying the *arr suite of services (Radarr, Sonarr, etc.) in Docker containers
* Installing Plex Media Server in a Docker container
* Setting up Traefik as the reverse proxy, with SSL termination and proper routing
* Making sure everything runs smoothly on Arch Linux and Ubuntu 22.04

Tested on:
* Arch Linux
* Ubuntu 22.04

Before you dive in, make sure you have:

* *Docker already installed* on the target machines (this role assumes Docker is present and doesn't handle the installation). You can use `geerlingguy.docker` to install docker
* Ansible 2.9+
* Traefik configuration basics (the role handles most of it, but a Traefik entrypoint would be useful!)

## How to Use

[Ansible Galaxy](https://galaxy.ansible.com/ui/standalone/roles/marcocot/arr_suite/install/)

Super simple to get started. Just include the role in your playbook:

```yaml
---
- hosts: all
  become: yes
  roles:
    - role: marcocot.arr_suite
```

If you want to configure the services (like ports, paths, or additional *arr apps), just set some variables like so:

```yaml
---
- hosts: all
  become: yes
  roles:
    - role: marcocot.arr_suite
  vars:
    arr_traefik_version: "3.1"
```

## Configurable Variables

Below is a table describing the key variables you can customize to fit your environment:

| **Variable**               | **Default Value**          | **Description**                                                      | **** | **** | **** | **** | **** | **** | **** |
| -------------------------- | -------------------------- | -------------------------------------------------------------------- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| arr_containers_service     | See example below          | List of services and their states (started, stopped, or absent)      |      |      |      |      |      |      |      |
| arr_containers_service_uid | 1000                       | User ID to run the services under (UID for the container processes)  |      |      |      |      |      |      |      |
| arr_containers_service_gid | 1000                       | Group ID to run the services under (GID for the container processes) |      |      |      |      |      |      |      |
| arr_traefik_version        | "3.1"                      | Version of Traefik to install                                        |      |      |      |      |      |      |      |
| arr_timezone               | Europe/Rome                | Timezone for the containers                                          |      |      |      |      |      |      |      |
| arr_domain                 | mydomain.com               | Domain to use for Traefik routing                                    |      |      |      |      |      |      |      |
| arr_acme_email             | ""                         | Email for Let's Encrypt ACME SSL certificates                        |      |      |      |      |      |      |      |
| arr_plex_package_name      | plex-media-server-plexpass | Plex package name (adjust if using a different Plex version)         |      |      |      |      |      |      |      |
| arr_archlinux_aur_helper   | yay                        | AUR helper to use on Arch Linux for installing packages              |      |      |      |      |      |      |      |
| arr_media_folder	| /mnt/media	| Default path where media files will be stored. The role creates a `downloads` folder for downloaded content and a `library` folder with subfolders `tv`, `comics`, and `movies` for the organized media files. |

### Example for `arr_containers_service`

```yaml
arr_containers_service:
  - name: prowlarr
    state: started
  - name: radarr
    state: started
  - name: sonarr
    state: started
  - name: bazarr
    state: started
  - name: calibre-web
    state: absent
  - name: qbittorrent
    state: absent
  - name: tautulli
    state: started
  - name: overseerr
    state: started
  - name: kavita
    state: started
  - name: mylar3
    state: started
```

This list lets you specify which services to run and their state (started, absent, etc.).

## Service Descriptions
Here’s a quick rundown of the services you can configure with this role, along with links to their official sites:

* [Prowlarr](https://prowlarr.com/): Indexer manager for *arr applications (handles the indexers for searching and finding media).
* [Radarr](https://radarr.video/): A movie collection manager, automating downloading and managing movie files.
* [Sonarr](https://sonarr.tv/): A TV show collection manager, automating downloading and managing TV show episodes.
* [Bazarr](https://www.bazarr.media/): A companion to Radarr and Sonarr, used for managing subtitles.
* [Calibre-Web](https://github.com/janeczku/calibre-web): A web-based ebook library manager, a nice addition for managing ebooks.
* [qBittorrent](https://www.qbittorrent.org/): An open-source BitTorrent client that handles downloading files. Often used as the download client for *arr apps.
* [Tautulli](https://tautulli.com/): A monitoring and tracking tool for Plex, showing what’s being watched and keeping logs.
* [Overseerr](https://overseerr.dev/): A request management and media discovery tool for the *arr suite, enabling users to request media.
* [Kavita](https://www.kavitareader.com/): A self-hosted digital library for managing comic and manga collections.
* [Mylar3](https://github.com/mylar3/mylar3): A media manager for comic books, providing automated downloads similar to Radarr/Sonarr.

## Running tests

To run tests locally, you need `Python 3.12`, `Poetry`, `Vagrant`, and `VirtualBox` installed. Here's how to set it up and run the tests:

### Install dependencies in the project folder with Poetry:

```bash
poetry install
```

### This will install Molecule and all other necessary dependencies.

Run the tests using Molecule with Vagrant and VirtualBox:

```bash
molecule test
```

Molecule will automatically use Vagrant and VirtualBox to spin up test instances, run the role, and verify its functionality.

Feel free to contribute or open an issue if something breaks (or if Traefik decides to change something again 😅).

# License

This project is licensed under the MIT License - see the LICENSE file for details.
