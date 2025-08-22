import { useInfiniteQuery } from '@tanstack/react-query';
import { FlatList, ListRenderItem, RefreshControl } from 'react-native';
import { Text, View } from '@/components/Themed';
import { useCallback, useMemo } from 'react';
import * as Haptics from 'expo-haptics';

interface TrendingItem {
  id: string;
  title: string;
  subtitle: string;
}

async function fetchTrending({ pageParam = 0 }: { pageParam?: number }) {
  // Placeholder API: simulate network latency and paginated results
  await new Promise((r) => setTimeout(r, 400));
  const pageSize = 20;
  const start = pageParam * pageSize;
  const items: TrendingItem[] = Array.from({ length: pageSize }).map((_, idx) => ({
    id: String(start + idx + 1),
    title: `Trend #${start + idx + 1}`,
    subtitle: 'Hot right now — sample data',
  }));
  const nextPage = pageParam < 9 ? pageParam + 1 : undefined; // 10 pages total
  return { items, nextPage };
}

export default function TrendingScreen() {
  const query = useInfiniteQuery({
    queryKey: ['trending'],
    queryFn: ({ pageParam }) => fetchTrending({ pageParam }),
    initialPageParam: 0,
    getNextPageParam: (lastPage) => lastPage.nextPage,
  });

  const data = useMemo(() => query.data?.pages.flatMap((p) => p.items) ?? [], [query.data]);

  const onEndReached = useCallback(() => {
    if (query.hasNextPage && !query.isFetchingNextPage) {
      query.fetchNextPage();
    }
  }, [query.hasNextPage, query.isFetchingNextPage, query.fetchNextPage]);

  const onRefresh = useCallback(async () => {
    await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
    await query.refetch();
  }, [query.refetch]);

  const renderItem: ListRenderItem<TrendingItem> = ({ item }) => (
    <View style={{ padding: 16, borderBottomWidth: 1, borderBottomColor: 'rgba(127,127,127,0.2)' }}>
      <Text style={{ fontSize: 16, fontWeight: '600' }}>{item.title}</Text>
      <Text style={{ opacity: 0.7, marginTop: 4 }}>{item.subtitle}</Text>
    </View>
  );

  return (
    <View style={{ flex: 1 }}>
      <FlatList
        data={data}
        keyExtractor={(item) => item.id}
        renderItem={renderItem}
        contentContainerStyle={{ paddingBottom: 16 }}
        onEndReachedThreshold={0.4}
        onEndReached={onEndReached}
        refreshControl={<RefreshControl refreshing={query.isRefetching} onRefresh={onRefresh} />}
        ListFooterComponent={
          query.isFetchingNextPage ? (
            <View style={{ padding: 16 }}>
              <Text>Loading more…</Text>
            </View>
          ) : null
        }
      />
    </View>
  );
}