# jackrschumacher-CyberChef

[![GitHub Release](https://img.shields.io/github/v/release/jackrschumacher/jackrschumacher-CyberChef)](https://github.com/jackrschumacher/jackrschumacher-CyberChef/releases) 

## CyberChef Local Build

This guide outlines the steps to compile [GCHQ's CyberChef](https://github.com/gchq/CyberChef) on your local machine

## Prerequisites
* Node.js and npm installed locally.
* Git installed locally.

## 1. Clone and Build Locally
First, download the source code and compile the production version of the application. 

```bash
git clone [https://github.com/gchq/CyberChef.git](https://github.com/gchq/CyberChef.git)
cd CyberChef
nvm install #Get reccomended node version from the current directory
npm install
npx grunt prod
cd ..
```
This build does generate a `.zip` file, but by adding that to the `.gitignore` prevents it from being pushed to the remote.
