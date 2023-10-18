/** @type {import('next').NextConfig} */
const nextConfig = {
  basePath: '/cadastro',
  assetPrefix: `/cadastro/${process.env.NEXT_PUBLIC_STATIC_VERSION}/`
}

module.exports = nextConfig
