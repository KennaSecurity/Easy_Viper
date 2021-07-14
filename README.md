# Easy Viper

## About The Project

Easy Viper allows you to build a local [Elastic Stack](https://www.elastic.co/elastic-stack/) quickly using docker-compose and import data directly from the Kenna VI+ API using Viper.

### Built With

* [Docker-Compose](https://docs.docker.com/compose/)
* [Elastic Stack](https://www.elastic.co/guide/en/elastic-stack-get-started/master/get-started-docker.html)
* [Viper](https://github.com/KennaSecurity/Viper)

## Getting Started

### Prerequisites

Easy Viper was built and tested on MacOS 11.4 and requires the following software:

* [Docker](https://docs.docker.com/docker-for-mac/install/)
  * [Minimum of 4GBs of Ram](https://docs.docker.com/docker-for-mac/)
* [Python3](https://www.python.org/downloads/)
  * [PIP3](https://pip.pypa.io/en/stable/)
  * [elasticsearch-loader](https://pypi.org/project/elasticsearch-loader/)

### Installation

1. Clone the repo

   ```sh
   git clone https://github.com/github_username/repo_name.git
   ```

2. Edit Varibles.txt

  ```sh
  VI_Plus_API_Key="YourAPIKey"
  Updated_Since="2021-07-11T00:00:00+0000"
  API="https://api.kennasecurity.com"
  ```

You will need to set the API to match your host as [described here](https://apidocs.kennasecurity.com/reference#authentication). It will default to the base API of [api.kennasecurity.com](https://api.kennasecurity.com).

## Usage

### To Start Easy Viper For The First Time

  ```sh
    ./easy_viper_build.sh
   ```

### To Stop Easy Viper

  ```sh
    ./easy_viper_down.sh
   ```

### To Start Easy Viper

  ```sh
    ./easy_viper_up.sh
   ```

### To Update Easy Viper

  ```sh
    ./easy_viper_update.sh
   ```

### To Delete The Easy Viper Stack

  ```sh
    ./easy_viper_delete.sh
   ```

### DashBoard Access

Once the shell script has finished running you can access the [Kibana Dashboard](http://localhost:5601/) at [http://localhost:5601/](http://localhost:5601/) to start exploring the data.

## Roadmap

* Auto Import Dashboards
* Scheduled Viper Runs

## Notes

Depending on your internet speed and the amount of data requested, startup can take 10 minutes to more than an hour.

## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Support

Use the [issues](https://github.com/KennaSecurity/Easy_Viper/issues) tab to report any problems or issues.

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Contact

Jerry Gamblin - [@jgamblin](https://twitter.com/jgamblin)
KennaSecurity - [KennaSecurity](https://twitter.com/jgamblin)
