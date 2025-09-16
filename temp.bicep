
@description('VNet 名')
param vnetName string = 'vnet-main'

@description('デプロイ先リージョン（既定は RG と同じ）')
param location string = resourceGroup().location

@description('VNet のアドレス空間（複数可）')
param addressPrefixes array = [
  '10.0.0.0/16'
]

@description('作成するサブネット一覧（名前とアドレスプレフィックス）')
param subnets array = [
  {
    name: 'default'
    addressPrefix: '10.0.0.0/24'
  }
]

@description('任意のタグ')
param tags object = {}

resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
    subnets: [
      for s in subnets: {
        name: s.name
        properties: {
          addressPrefix: s.addressPrefix
        }
      }
    ]
  }


output vnetId string = vnet.id
