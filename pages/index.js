import useDocusaurusContext from "@docusaurus/useDocusaurusContext"
import React from "react"

import Layout from "@theme/Layout"
import Admonition from "@theme/Admonition"
import Link from "@docusaurus/Link"

import styles from "./index.module.css"

function Hero() {
  const { siteConfig } = useDocusaurusContext()
  return (
    <header className={styles.heroBanner}>
      <div className="container">
        <h1 className="hero__title">CmdrX</h1>
        <p className="hero__subtitle">{siteConfig.tagline}</p>
        <div className={styles.buttons}>
          <Link
            className={`button button--success button--lg ${styles.button}`}
            to="/docs/intro"
          >
            Get Started
          </Link>

          <Link
            className={`button button--secondary button--lg ${styles.button}`}
            to="/api"
          >
            API Documentation
          </Link>
        </div>
      </div>
    </header>
  )
}

function Feature({ title, description }) {
  return (
    <div className={styles.feature}>
      <h3>{title}</h3>
      <p>{description}</p>
    </div>
  )
}

export default function Home() {
  const { tagline } = useDocusaurusContext()
  return (
    <Layout title="" description={tagline}>
      <Hero />
      <main>
        <div className="container">
          <Admonition type="info" title="Beta">
            This website is a new service and <a href="https://github.com/BiraruStudios/CmdrX/issues/new?assignees=&labels=scope%3Aixp&projects=&template=websitefeedback.md" target="_blank">your feedback</a> will help improve it.
          </Admonition>

          <section className={styles.featuresOuter}>
            <div className={styles.featuresInner}>
              <Feature title="Integrates with your systems" description="CmdrX stays out of the way, making it easy to write your own commands which plug-in to your systems. Help debug your game by triggering events or printing useful data." />
              <Feature title="Type-safe with intelligent autocomplete" description="Discover commands and possible values for arguments naturally with context-aware autocomplete. Arguments are strictly typed and validated for you, keeping typos at bay." />
              <Feature title="Powerful and extensible" description="CmdrX ships with optional built-in commands but you can register your own commands and types. Meta-commands like bind and alias make it possible to extend CmdrX even further." />
            </div>
          </section>

          <p className={styles.paragraphs}>
            Building on the legacy of the original project, <strong>CmdrX</strong> is a modernized fork designed to keep debugging and administrative workflows seamless. While the original was popularized as a versatile console system, CmdrX carries that extensible nature forward with updated standards, ensuring it works exactly the way you need it to for any project.
          </p>

          <p className={styles.paragraphs}>
            CmdrX maintains the same friendly API that developers love, allowing full control over how the system operates. Easily register custom commands, define your own activation keybinds, or toggle the entire system—all within a framework optimized for modern Roblox development.
          </p>

          <p className={styles.paragraphs}>
            CmdrX inherits a robust type validation system that provides users with real-time feedback as they type. By enforcing strict type checks before a command ever reaches your code, CmdrX keeps your logic clean and protects your game from both simple typos and malicious exploiters.
          </p>

          <p className={styles.paragraphs}>
            As a fork of a system that has been trusted for over five years in games with billions of visits, CmdrX combines battle-tested reliability with community-driven improvements and modern maintenance. <Link to="/docs/intro#why-should-i-use-it">Tell me more →</Link>
          </p>
        </div>
      </main>
    </Layout>
  )
}
