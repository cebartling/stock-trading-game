import Axios from "axios";

require('dotenv').config();

export const stockInfo = async (obj, args, context, info) => {
    const baseUrl = `https://www.alphavantage.co/query`;
    const timeSeries = `function=TIME_SERIES_DAILY`;
    const symbol = `symbol=${args.symbol}`;
    const outputSize = `outputsize=full`;
    const apiKey = `apikey=${process.env.ALPHA_VANTAGE_API_KEY}`;
    const response = await Axios.get(`${baseUrl}?${timeSeries}&${symbol}&${outputSize}&${apiKey}`);
    console.log(response);
    return {symbol: args.symbol, companyName: 'Microsoft'};
};