/**
 * Copyright (c) 2017-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

const React = require('react');

const CompLibrary = require('../../core/CompLibrary.js');

const MarkdownBlock = CompLibrary.MarkdownBlock; /* Used to read markdown */
const Container = CompLibrary.Container;
const GridBlock = CompLibrary.GridBlock;

class HomeSplash extends React.Component {
  render() {
    const { siteConfig, language = '' } = this.props;
    const { baseUrl, docsUrl } = siteConfig;
    const docsPart = `${docsUrl ? `${docsUrl}/` : ''}`;
    const langPart = `${language ? `${language}/` : ''}`;
    const docUrl = doc => `${baseUrl}${docsPart}${langPart}${doc}`;

    const SplashContainer = props => (
      <div className="homeContainer">
        <div className="homeSplashFade">
          <div className="wrapper homeWrapper">{props.children}</div>
        </div>
      </div>
    );

    const ProjectTitle = () => (
      <h2 className="projectTitle">
        {siteConfig.title}
        <small>{siteConfig.tagline}</small>
      </h2>
    );

    const PromoSection = props => (
      <div className="section promoSection">
        <div className="promoRow">
          <div className="pluginRowBlock">{props.children}</div>
        </div>
      </div>
    );

    const Button = props => (
      <div className="pluginWrapper buttonWrapper">
        <a className="button" href={props.href} target={props.target}>
          {props.children}
        </a>
      </div>
    );

    return (
      <SplashContainer>
        <div className="inner">
          <ProjectTitle siteConfig={siteConfig} />
          <PromoSection>
            <Button href={docUrl('deployment.html')}>Get Started</Button>
            <Button href={docUrl('running-a-hackathon.html')}>Docs</Button>
            <Button href="https://github.com/codeRIT/hackathon-manager">
              GitHub
            </Button>
          </PromoSection>
        </div>
      </SplashContainer>
    );
  }
}

class Index extends React.Component {
  render() {
    const { config: siteConfig, language = '' } = this.props;
    const { baseUrl } = siteConfig;

    const Block = props => (
      <Container
        padding={['bottom', 'top']}
        id={props.id}
        background={props.background}
      >
        <GridBlock
          align="center"
          contents={props.children}
          layout={props.layout}
        />
      </Container>
    );

    const Features = () => (
      <Block layout="threeColumn">
        {[
          {
            content:
              'HackathonManager is the product of running various hackathons over the past 5 years',
            image: `${baseUrl}img/undraw_predictive_analytics_kf9n.svg`,
            imageAlign: 'top',
            title: 'Battle-tested',
          },
          {
            content:
              'Manage every component of a hackathon that deals with attendees',
            image: `${baseUrl}img/undraw_adjustments_p22m.svg`,
            imageAlign: 'top',
            title: 'All-in-one',
          },
          {
            content:
              'Scale from 200 to 2000 applicants with tools to empower your organizing team',
            image: `${baseUrl}img/undraw_QA_engineers_dg5p.svg`,
            imageAlign: 'top',
            title: 'Production ready',
          },
        ]}
      </Block>
    );

    const Applications = () => (
      <Block background="light">
        {[
          {
            content:
              'Enable hackers to apply to your hackathon while providing all relevant information (contact info, school, demographics, etc)',
            image: `${baseUrl}img/applications.png`,
            imageAlign: 'right',
            title: 'Applications',
          },
        ]}
      </Block>
    );

    const Admissions = () => (
      <Block>
        {[
          {
            content:
              'Facilitate accepting hackers to your hackathon & enable them to RSVP',
            image: `${baseUrl}img/rsvp.png`,
            imageAlign: 'left',
            title: 'Admissions & RSVPs',
          },
        ]}
      </Block>
    );

    const BusLists = () => (
      <Block background="light">
        {[
          {
            content:
              'Coordinate bus sign-ups during the RSVP process while communicating important information to riders & captains',
            image: `${baseUrl}img/editbuslist.png`,
            imageAlign: 'right',
            title: 'Bus Lists',
          },
        ]}
      </Block>
    );

    const MyMLHSupport = () => (
      <Block>
        {[
          {
            content:
              "Streamline the application process when users log in with [MyMLH](https://my.mlh.io/), a common platform for applying to any MLH hackathon. Basic info is pre-filled based on a common application, so hackers don't have to re-type it every time.<br /><br />Learn more at [my.mlh.io](https://my.mlh.io/)",
            image: `${baseUrl}img/mymlh.png`,
            imageAlign: 'left',
            title: 'MyMLH Support',
          },
        ]}
      </Block>
    );

    const EmailCommunication = () => (
      <Block background="light">
        {[
          {
            content:
              'Ensure hackers get consistent, timely information throughout their application process, while enabling your organizing team to communicate important information at any time.',
            image: `${baseUrl}img/messageedit.png`,
            imageAlign: 'right',
            title: 'Email Communication',
          },
        ]}
      </Block>
    );

    const StatisticsVisualization = () => (
      <Block>
        {[
          {
            content:
              'Surface key analytics about your admissions, distribution of applicants, progress towards attendance, etc.',
            image: `${baseUrl}img/dashboard.png`,
            imageAlign: 'left',
            title: 'Statistics & Visualization',
          },
        ]}
      </Block>
    );

    const Showcase = () => {
      if ((siteConfig.users || []).length === 0) {
        return null;
      }

      const showcase = siteConfig.users.map(user => (
        <a href={user.infoLink} key={user.infoLink}>
          <img src={user.image} alt={user.caption} title={user.caption} />
        </a>
      ));

      return (
        <div className="productShowcaseSection paddingBottom">
          <h2>Who is Using This?</h2>
          <p>This project is used by all these people</p>
          <div className="logos">{showcase}</div>
        </div>
      );
    };

    return (
      <div>
        <HomeSplash siteConfig={siteConfig} language={language} />
        <div className="mainContainer">
          <Features />
          <Applications />
          <Admissions />
          <BusLists />
          <MyMLHSupport />
          <EmailCommunication />
          <StatisticsVisualization />
          <Showcase />
        </div>
      </div>
    );
  }
}

module.exports = Index;
