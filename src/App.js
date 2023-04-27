import React, { useState } from "react";
import axios from "axios";

const buttonStyle = {
  backgroundColor: "#3498db",
  border: "none",
  color: "#fff",
  padding: "10px 20px",
  fontSize: "16px",
  fontWeight: "bold",
  borderRadius: "5px",
  margin: "5px",
  cursor: "pointer"
};

function App() {
  const [IDO1Data, setIDO1Data] = useState(null);
  const [fundIDOData, setFundIDOData] = useState(null);
  const [transferIDOFundsData, setTransferIDOFundsData] = useState(null);

  const handleIDO1Click = () => {
    axios
      .get(
        "https://mumbai.polygonscan.com/address/0xDC821916B26d32F8fAf77BE7FCe79e88E38bceA2"
      )
      .then((response) => {
        setIDO1Data(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  };

  const handleFundIDOClick = () => {
    axios
      .get(
        "https://mumbai.polygonscan.com/address/0xDC821916B26d32F8fAf77BE7FCe79e88E38bceA2"
      )
      .then((response) => {
        setFundIDOData(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  };

  const handleTransferIDOFundsClick = () => {
    axios
      .get(
        "https://mumbai.polygonscan.com/address/0xDC821916B26d32F8fAf77BE7FCe79e88E38bceA2"
      )
      .then((response) => {
        setTransferIDOFundsData(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  };

  return (
    <div
      style={{
        backgroundColor: "#ecf0f1",
        minHeight: "100vh",
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center"
      }}
    >
      <h1 style={{ marginBottom: "20px" }}>My App</h1>
      <div style={{ display: "flex", flexDirection: "row" }}>
        <button style={buttonStyle} onClick={handleIDO1Click}>
          IDO1
        </button>
        <button style={buttonStyle} onClick={handleFundIDOClick}>
          Fund IDO
        </button>
        <button style={buttonStyle} onClick={handleTransferIDOFundsClick}>
          Transfer IDO Funds
        </button>
      </div>
      {IDO1Data && <p>IDO1 Data: {IDO1Data}</p>}
      {fundIDOData && <p>Fund IDO Data: {fundIDOData}</p>}
      {transferIDOFundsData && (
        <p>Transfer IDO Funds Data: {transferIDOFundsData}</p>
      )}
    </div>
  );
}

export default App;

