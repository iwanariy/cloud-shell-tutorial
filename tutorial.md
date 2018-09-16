# Cloud Shell Demo

## 概要
本チュートリアルでは、 **Tutorials in Cloud Shell**を利用しながら、Cloud Shell を用いてアプリケーションを開発する流れをご紹介します。

それでは、**続行** をクリックして、次のステップに進みましょう。


## チュートリアルの流れ
Cloud Shell を用いて、アプリケーション開発〜サーバ構築までを実施します。

1. アプリケーションコード開発
2. アプリケーションを起動 & 動作確認
3. サーバ作成 & アプリデプロイ
4. サーバにSSHログインして、中身を確認

## アプリケーションコード開発
以下の内容で、`app.py`を作成します。

<walkthrough-editor-spotlight spotlightId="fileMenu" text="ファイルメニュー">
</walkthrough-editor-spotlight>
から、新しいファイルを作成しましょう。

```python
from flask import Flask
app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'Hello world!'


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port='8080')
```

次は、アプリケーションをCloud Shell内で起動してみましょう。

## アプリケーションを起動 & 動作確認
まず、
<walkthrough-spotlight-pointer spotlightId="devshell-activate-button" text="Cloud Shellを起動">
</walkthrough-spotlight-pointer>
してみましょう。

次に、Cloud Shellで以下のコマンドを実行し、アプリケーションを起動しましょう。

```bash
sudo pip install Flask==1.0.2
```

```bash
python app.py
```
**Tips**: コードボックスの右のアイコンをクリックすることで、コマンドをCloud Shellにコピーできます

ここでは、Cloud Shellの中でアプリケーションが動いている状態です。  
Webプレビュー機能を用いて、アプリケーションの動作を確認してみましょう。

<walkthrough-spotlight-pointer spotlightId="devshell-web-preview-button" text="Webプレビューのボタンをクリック">
</walkthrough-spotlight-pointer>
し、アプリケーションにアクセスしてみましょう。

アプリケーションの動作を確認することができたでしょうか？  
それでは、次はサーバを構築し、アプリケーションをデプロイしてみましょう。

## サーバ作成 & アプリデプロイ

今回は、事前にコンテナ化したアプリケーションを用いて、サーバ構築 & デプロイを構築してみます。  
もちろん、Cloud Console からサーバを作成してもokです。

```bash
PROJECT_ID=iwanariy-sandbox-189101
```

```bash
gcloud beta compute --project=${PROJECT_ID} instances create-with-container demo --zone=asia-northeast1-b --machine-type=n1-standard-1 --subnet=default --network-tier=PREMIUM --maintenance-policy=MIGRATE --service-account=491590359618-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --tags=http-server --image=cos-stable-67-10575-66-0 --image-project=cos-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=demo --container-image=gcr.io/${PROJECT_ID}/simple-app:NEXT --container-restart-policy=always --labels=container-vm=cos-stable-67-10575-66-0
```

**Notice**: プロジェクト名、サービスアカウントは適宜ご変更ください

なお、コンテナ化するためのコマンドは下記。
```bash
gcloud builds submit . --tag=gcr.io/${DEVSHELL_PROJECT_ID}/simple-app:NEXT
```

## サーバにSSHログインして、中身を確認

さて、実際にサーバが構築されているか、[Cloud Console](https://console.cloud.google.com/compute/instances)で確認してみましょう。

「SSH」ボタンをクリックして仮想マシンに接続し、 `docker ps` コマンドで、アプリケーションが起動していることを確認しましょう。  

## Congratulations

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

## Clean up
```bash
gcloud compute instances delete demo --zone=asia-northeast1-b
```
