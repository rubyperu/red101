import React from 'react';
import Modals from "../components/Modals";
import { Link } from 'react-router';

const Layout = ({ children }) => (
  <div className="container">
    {children}
    <Modals />
  </div>
);

Layout.propTypes = {
  children: React.PropTypes.object,
};

export default Layout;
