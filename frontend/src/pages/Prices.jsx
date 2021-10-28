import React from 'react'
import { useCoingeckoPrice, useCoingeckoTokenPrice } from '@usedapp/coingecko'
import { Container, ContentBlock, ContentRow, MainContent, Section, SectionRow } from '../components/base/base'
import { Label } from '../typography/Label'
import { TextInline } from '../typography/Text'
import { Title } from '../typography/Title'

export function Prices() {
  const etherPrice = useCoingeckoPrice('ethereum', 'usd')

  return (
    <MainContent>
      <Container>
        <Section>
          <SectionRow>
            <Title>Price</Title>
          </SectionRow>
          <ContentBlock>
            {etherPrice && (
              <ContentRow>
                <Label>Ethereum price:</Label> <Label>$ </Label>
                <TextInline>{etherPrice}</TextInline>
              </ContentRow>
            )}
          </ContentBlock>
        </Section>
      </Container>
    </MainContent>
  )
}
