import auth from '../../client.json'

export const environment = {
  production: false,
  apiUrl: 'http://apicrm.loc/',
  clientSecret: auth.clientSecret,
  clientId: auth.clientId
};